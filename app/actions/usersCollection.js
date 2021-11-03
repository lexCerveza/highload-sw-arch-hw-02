const { Schema, model } = require('mongoose')

const userShema = Schema({
  password: {
    type: String,
    required: [true, 'Password is required'],
  },
  email: {
    type: String,
    required: [true, 'Email is required'],
    unique: true,
  }
}, { versionKey: false, timestamps: true })

const usersCollection = model('users', userShema)

module.exports = usersCollection