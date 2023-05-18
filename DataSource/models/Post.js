const mongoose = require('mongoose')

const PostSchema = mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    signature: {
        type: String,
        required: true
    }
})
/* Should it be required I can add the date of
 * submission of the post, but it does not add
 * any functionality useful for our purposes
 */

module.exports = mongoose.model('Posts', PostSchema)