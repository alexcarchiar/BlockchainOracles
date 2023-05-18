const express = require('express')
const router = express.Router();
const Post = require('../models/Post')
const crypto = require('crypto')
require('dotenv/config')

const private_Key = process.env.PRIVATE_KEY
const signing_algorithm = 'sha256'
const format_string = 'hex'
const public_key = process.env.PUBLIC_KEY

router.get('/', async (req, res) => { //get all posts
    try {
        const posts = await Post.find()
        res.json(posts)
    } catch(err) {
        console.log(err)
        res.json({message: err})
    }
})

router.post('/', async (req, res) => { //submit one new posts
    console.log("received")
    console.log(req.body)
    let signer = crypto.createSign(signing_algorithm)
    signer.update(req.body.title)
    signer.update(req.body.description)
    signer.end()
    let signature = signer.sign(private_Key,format_string)

    const post = new Post({
        title: req.body.title,
        description: req.body.description,
        signature: signature
    })

    let verifier = crypto.createVerify(signing_algorithm)
    verifier.update(req.body.title)
    verifier.update(req.body.description)
    verifier.end()
    console.log(verifier.verify(public_key, signature, format_string))

    try {
        const saved = await post.save()
        console.log("saving")
        console.log(saved)
        res.json(saved)
    } catch (err) {
        res.json({message: err})
        console.log(err)
    }
})

//get latest  post
router.get('/latest', async (req, res) => {
    console.log("Getting latest")
    try {
        const latestPost = await Post.find().sort({ _id: -1 }).limit(1)
        res.json(latestPost[0])
        console.log(latestPost[0])
    } catch(err) {
        console.log(err)
        res.json({message:err})
    }
})

/*should it be required, I can make it so that one can look
 * look for a specific posts, but one would need the 
 * postID given by MongoDB
 */

module.exports = router
