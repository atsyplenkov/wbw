import numpy as np


def wbw_to_vector(wbw_raster, raw=False):
    """
    Converts a Whitebox Raster object to a 1d numpy array, column-wise.

    Args:
        wbw_raster: A Whitebox Raster object
        raw: If False (default), replaces NoData values with None/np.nan. If True, keeps original values.

    Returns:
        A 1d numpy array with values arranged column by column.
    """
    # First get the data as a matrix
    matrix = wbw_to_matrix(wbw_raster, raw=raw)

    # Convert to 1D array column-wise (Fortran-style ordering)
    return matrix.flatten(order="C")


def wbw_to_matrix(wbw_raster, raw=False):
    """
    Converts a Whitebox Raster object to a 2d numpy array.

    Args:
        wbw_raster: A Whitebox Raster object
        raw: If False (default), replaces NoData values with None/np.nan. If True, keeps original values.

    Returns:
        A 2d numpy array.
    """
    nrows = wbw_raster.configs.rows
    ncols = wbw_raster.configs.columns
    dtype = raster_dtype(wbw_raster)

    # For integer types, convert to float64 if we need to represent NoData
    if not raw and np.issubdtype(dtype, np.integer):
        dtype = np.float64

    matrix = np.zeros((nrows, ncols), dtype=dtype)

    for i in range(nrows):
        matrix[i] = wbw_raster.get_row_data(i)

    if not raw:
        nodata = wbw_raster.configs.nodata
        matrix[matrix == nodata] = np.nan

    return matrix


def matrix_to_wbw(matrix, wbw_raster):
    """
    Writes a 2d numpy array to a Whitebox Raster object.

    Args:
        matrix: A 2d numpy array with values to write
        wbw_raster: A Whitebox Raster object to write the data to

    Returns:
        None. The wbw_raster is modified in place.
    """
    if matrix.shape != (wbw_raster.configs.rows, wbw_raster.configs.columns):
        raise ValueError(
            f"Matrix shape {matrix.shape} does not match raster dimensions "
            f"({wbw_raster.configs.rows}, {wbw_raster.configs.columns})"
        )

    # Ensure matrix data type matches raster
    target_dtype = raster_dtype(wbw_raster)
    if matrix.dtype != target_dtype:
        matrix = matrix.astype(target_dtype)

    # Write data row by row
    for i in range(wbw_raster.configs.rows):
        wbw_raster.set_row_data(i, matrix[i])


def raster_dtype(wbw_raster):
    dtype_mapping = {
        "RasterDataType.F64": np.float64,
        "RasterDataType.F32": np.float32,
        "RasterDataType.I64": np.int64,
        "RasterDataType.U64": np.uint64,
        "RasterDataType.RGB48": np.uint16,  # Typically represented as unsigned 16-bit
        "RasterDataType.I32": np.int32,
        "RasterDataType.U32": np.uint32,
        "RasterDataType.RGB24": np.uint8,  # Typically represented as unsigned 8-bit
        "RasterDataType.RGBA32": np.uint8,  # Assuming RGBA32 as unsigned 8-bit per channel
        "RasterDataType.I16": np.int16,
        "RasterDataType.U16": np.uint16,
        "RasterDataType.I8": np.int8,
        "RasterDataType.U8": np.uint8,
    }

    dt = str(wbw_raster.configs.data_type)

    return dtype_mapping.get(dt, None)
