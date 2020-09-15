# An example which shows how you can preload some data once and access it in every
# request without having to load it for every request. For example, let's say you want
# to load a huge machine learning model only once and use it for all requests
# (read-only). Loading the machine learning model for every request is inefficient.
# Any data that you place in the global namespace will automatically be made available
# to all requests provided your platform supports the 'forkserver' multiprocessing
# context. This includes global variables as well as imports from other modules.

import time

from preloadhelper import ml_model_1

def load_model():
    # Using sleep to simulate a load model operation that takes a long time
    time.sleep(2)
    return {'b': 'world'}

ml_model_2 = load_model()

def handler(event, context):
    # Both 'ml_model_1' and 'ml_model_2' are preloaded once and are available to all
    # requests immediately without being loaded again for every request.
    return ml_model_1['a'] + ' ' + ml_model_2['b']
