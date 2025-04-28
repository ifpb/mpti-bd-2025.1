#!/bin/bash

DB_NAME="mptibd"

# Insert multiple documents into the "alunos" collection
mongo $DB_NAME --eval 'db.getCollection("alunos").insertMany([
    { nome: "Lucas", idade: 20, curso: "Engenharia de Software" },
    { nome: "Ana", idade: 22, curso: "Ciência da Computação" },
    { nome: "Pedro", idade: 19, curso: "Sistemas de Informação" },
    { nome: "Maria", idade: 21, curso: "Engenharia de Dados" },
    { nome: "João", idade: 23, curso: "Engenharia de Software" },
    { nome: "Fernanda", idade: 20, curso: "Ciência da Computação" },
    { nome: "Carlos", idade: 22, curso: "Sistemas de Informação" },
    { nome: "Juliana", idade: 19, curso: "Engenharia de Dados" }
]);'

# Find all documents in the "alunos" collection
mongo $DB_NAME --eval 'db.getCollection("alunos").find({}).pretty();'

# Insert a single document into the "alunos" collection
mongo $DB_NAME --eval 'db.getCollection("alunos").insertOne({
    nome: "João Victor",
    idade: 20,
    curso: "Mestrado em Tecnologia da Informação",
    notas: [
        { disciplina: "Matemática", nota: 8.5 },
        { disciplina: "Programação", nota: 9.0 },
        { disciplina: "Banco de Dados", nota: 7.5 }
    ]
});'

# Find documents where "idade" is less than 21
mongo $DB_NAME --eval 'db.getCollection("alunos").find({ idade: { $lt: 21 } }).pretty();'

# Update documents to add "notas" field if it doesn't exist
mongo $DB_NAME --eval 'db.getCollection("alunos").updateMany(
    { notas: { $exists: false } },
    {
        $set: { notas: [
            { disciplina: "Matemática", nota: 0 },
            { disciplina: "Programação", nota: 0 },
            { disciplina: "Banco de Dados", nota: 0 }
        ]}
    }
);'

# Update documents where "notas" contain a "nota" of 0
mongo $DB_NAME --eval 'db.getCollection("alunos").updateMany(
    { notas: { $elemMatch: { nota: 0 } } },
    {
        $set: { notas: [
            { disciplina: "Matemática", nota: 10 },
            { disciplina: "Programação", nota: 10 },
            { disciplina: "Banco de Dados", nota: 10 }
        ]}
    }
);'

# Delete a document where "nome" is "Carlos"
mongo $DB_NAME --eval 'db.getCollection("alunos").deleteOne({ nome: { $eq: "Carlos" } });'

# Delete documents where "idade" is less than 20
mongo $DB_NAME --eval 'db.getCollection("alunos").deleteMany({ idade: { $lt: 20 } });'