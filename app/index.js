const express = require('express')
const mongoose = require('mongoose')
const Chance = require('chance')
const createUser = require('./actions/createUser')
const getRandomUser = require('./actions/getRandomUser')

require('dotenv').config()

const { PORT, MONGO_CONNECTION_STRING } = process.env
const chance = new Chance()

const app = express()
app.use(express.json())

app.post('/api/users', async (req, res) => {
  const { email, password } = req.body
  await createUser(email, password)

  res.status(201).json({ message : 'User created' })
})

app.get('/api/users', async (req, res) => {
  const user = await getRandomUser(email)
  res.status(200).json(user)
})

mongoose
  .connect(MONGO_CONNECTION_STRING, { useUnifiedTopology: true })
  .then(() => console.log('Database connection successful'))
  .then(async () => {
    for (let i = 0; i < 100; i++) {
      await createUser(chance.email(), chance.word())
    }
  })
  .then(() => console.log('Data seeded'))
  .then(() => {
    app.listen(PORT, () => {
      console.log(`Server running. Use our API on port: ${PORT}`)
    })
  })
  .catch((err) => {
    console.log(err.message)
    process.exit(1)
  })