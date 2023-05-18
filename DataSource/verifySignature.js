//import keys and set variables
const private_key = process.env.PRIVATE_KEY
const signing_algorithm = 'sha256'
const format_string = 'hex'
const public_key = process.env.PUBLIC_KEY
const first_string = "example1"
const second_string = "example2"

//sign
let signer = crypto.createSign(signing_algorithm)
    signer.update(first_string)
    signer.update(second_string)
    signer.end()
let signature = signer.sign(private_key,format_string)

//verify
let verifier = crypto.createVerify(signing_algorithm)
    verifier.update(req.body.title)
    verifier.update(req.body.description)
    verifier.end()
    console.log(verifier.verify(public_key, signature, format_string))
