from pymongo import MongoClient

mongo_uri = "mongodb://localhost:27017"

client = MongoClient(mongo_uri)
db = client['mptibd']

print("Collections:", db.list_collection_names())

alunos = db.get_collection('alunos').find()
for aluno in alunos:
    print(aluno)
    print("Nome:", aluno['nome'])
    print("Idade:", aluno['idade'])
    print("Curso:", aluno['curso'])
    print("Notas:", aluno['notas'])
    print()

db.get_collection('alunos').insert_one({
    'nome': 'José da Silva Xavier',
    'idade': 50,
    'curso': 'Engenharia de Software',
    'notas': [8.5, 9.0, 7.5]
})

db.get_collection('alunos').delete_many({
    'idade': { '$gte': 50 }
})

db.get_collection('xyz').insert_one({
    'nome': 'José da Silva Xavier',
    'idade': 50,
    'curso': 'Engenharia de Software',
    'notas': [8.5, 9.0, 7.5]
})

resultado = db.get_collection('alunos').aggregate([
    { '$match': { 'curso': 'Engenharia de Software' } },
    { '$project': { 'nome': 1, 'notas': 1 } },
    {
        '$group': {
            '_id': '$curso',
            'media': { '$avg': '$notas' }
        }
    },
    {
        '$sort': { 'media': -1 }
    }
])

for doc in resultado:
    print(doc)