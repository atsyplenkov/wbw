import numpy as np


def wbw_to_matrix(wbw_raster):
    """
    Converts a Whitebox Raster object to a 2d numpy array.

    Args:
        wbw_raster: A Whitebox Raster object

    Returns:
        A 2d numpy array.
    """
    nrows = wbw_raster.configs.rows
    ncols = wbw_raster.configs.columns

    matrix = np.zeros((nrows, ncols), dtype=raster_dtype(wbw_raster))

    for i in range(nrows):
        matrix[i] = wbw_raster.get_row_data(i)

    return matrix

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
