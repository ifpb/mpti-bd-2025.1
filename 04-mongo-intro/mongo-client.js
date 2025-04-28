db.getCollection("alunos").insertMany([
    { nome: "Lucas", idade: 20, curso: "Engenharia de Software" },
    { nome: "Ana", idade: 22, curso: "Ciência da Computação" },
    { nome: "Pedro", idade: 19, curso: "Sistemas de Informação" },
    { nome: "Maria", idade: 21, curso: "Engenharia de Dados" },
    { nome: "João", idade: 23, curso: "Engenharia de Software" },
    { nome: "Fernanda", idade: 20, curso: "Ciência da Computação" },
    { nome: "Carlos", idade: 22, curso: "Sistemas de Informação" },
    { nome: "Juliana", idade: 19, curso: "Engenharia de Dados" }
]);

use("mptibd");
db.getCollection("alunos").find({}).pretty();

use("mptibd");
db.getCollection("alunos").insertOne({
    nome: "João Victor",
    idade: 20,
    curso: "Mestrado em Tecnologia da Informação",
    notas: [
        { disciplina: "Matemática", nota: 8.5 },
        { disciplina: "Programação", nota: 9.0 },
        { disciplina: "Banco de Dados", nota: 7.5 }
    ]
})

db.getCollection("alunos").find({
    idade: { $lt: 21 },
}).pretty();

use("mptibd");
db.getCollection("alunos").updateMany(
    { notas: { $exists: false } },
    {
        "$set": { notas: [
        {
            disciplina: "Matemática",
            nota: 0
        },
        {
            disciplina: "Programação",
            nota: 0
        },
        {
            disciplina: "Banco de Dados",
            nota: 0
        }]
    }
})

use("mptibd");
db.getCollection("alunos").updateMany(
    { notas: { $elemMatch: { nota: 0 } } },
    {
        "$set": { notas: [
        {
            disciplina: "Matemática",
            nota: 10
        },
        {
            disciplina: "Programação",
            nota: 10
        },
        {
            disciplina: "Banco de Dados",
            nota: 10
        }]
    }
})

use("mptibd");
db.getCollection("alunos").deleteOne(
    { "nome": { "$eq": "Carlos" }}
)


use("mptibd");
db.getCollection("alunos").deleteMany(
    { "idade": { "$lt": 20 }}
)
