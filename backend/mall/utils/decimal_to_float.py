from decimal import Decimal


def convert_decimals_to_floats(data):
    if isinstance(data, dict):
        return {key: convert_decimals_to_floats(value) for key, value in data.items()}
    elif isinstance(data, list):
        return [convert_decimals_to_floats(item) for item in data]
    elif isinstance(data, Decimal):
        return float(data)
    else:
        return data
