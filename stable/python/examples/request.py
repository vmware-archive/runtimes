# This example shows how you can access additional attributes from the request object.
# For additional information on how to use the request object, see
# https://bottlepy.org/docs/stable/tutorial.html#request-data
#
# Ex: curl -H "Say-Hello-To: John" http://<IP>:<PORT>/<FUNCTION>?greeting=Hola
#     should return "Hola John"

import os

def handler(event, context):
    req = event['extensions']['request']

    # Get user-defined headers
    name = req.get_header('Say-Hello-To', 'kubeless')

    # Get URL arguments
    greeting = req.query.get('greeting', 'Hello')

    # Access multipart/form-data
    category = req.forms.get('category')
    upload = req.files.get('upload')
    save_path = os.path.join("/tmp", category)
    os.makedirs(save_path, exist_ok=True)
    file_path = os.path.join(save_path, upload.filename)
    upload.save(file_path, overwrite=True)

    return greeting + ' ' + name
