//generate key pair
var keyPair = crypto.generateKeyPairSync('ec', {
  namedCurve: 'secp256k1',   // Options
  publicKeyEncoding: {
    type: 'spki',
    format: 'pem'
  },
  privateKeyEncoding: {
    type: 'pkcs8',
    format: 'pem'
  }
});

console.log(keyPair.privateKey)
console.log(keyPair.publicKey)

//import key
private_Key = process.env.PRIVATE_KEY
console.log(private_Key)
console.log("please")
console.log(crypto.createPrivateKey({
    key: private_Key,
    type: 'pkcs8',
    format: 'pem'
}))
console.log(crypto.createPrivateKey({
    key: private_Key,
    type: 'pkcs8',
    format: 'pem'
}).export({
    type: 'pkcs8',
    format: 'pem'
}))