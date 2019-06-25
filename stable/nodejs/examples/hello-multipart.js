'use strict';

const multer = require('multer');

// Empty configuration for this example. File will be stored in memory.
const upload = multer({});

const FILENAME = 'file';
const MULTIPART_TYPE = 'multipart/*';

module.exports = {
    handler: (event, context) => {
        let fileContent;
        if (event.extensions.request.is(MULTIPART_TYPE)) {
            const uploadPromise = new Promise((resolve, reject) => {
                // This is the workaround for using multer without being part of a express middleware.
                upload.single(FILENAME)(event.extensions.request, {}, (err) => {
                    if (err) return reject(err);
                    return resolve({
                        fields: event.extensions.request.body,
                        file: event.extensions.request.file,
                    });
                });
            });

            fileContent = uploadPromise.then(body => {
                // body.fields is a JS object that contains all the additional properties. 
                // In this example it looks like -> fields: { prop: 'This is a normal prop' }.
                // body.file has the multer object. More info: https://www.npmjs.com/package/multer
                if (!body.file) {
                    return 'You did not upload a file.'
                }
                return body.file.buffer.toString();
            }).catch(err => {
                console.error(err);
                return err.message;
            })
        } else {
            fileContent = 'The request is not multipart.';
        }
        
        return fileContent;
    },
};
