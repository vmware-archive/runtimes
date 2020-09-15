import time

def load_model():
    # Using sleep to simulate a load model operation that takes a long time
    time.sleep(2)
    return {'a': 'hello'}

ml_model_1 = load_model()
