# Exemplos de Consultas MongoDB

Exemplos de consultas MongoDB usando o seguinte documento JSON como base:

```json
{
    "_id": {
        "$oid": "62c5956744d10d4b78ae3b12"
    },
    "titulo": "Cassandra - The Definitive Guide",
    "descricao": "Introdução ao Cassandra",
    "by": "Reilly Media",
    "url": "https://cassandra.apache.org/",
    "tags": [
        "mongodb",
        "database",
        "NoSQL",
        "descentralized"
    ],
    "likes": 100.0,
    "comentarios": [
        {
            "usuario": "Higor",
            "mensagem": "Fundamental",
            "dateCreated": "2022-05-19",
            "likes": 9.0
        },
        {
            "usuario": "Larissa",
            "mensagem": "Bem fundamentado",
            "dateCreated": "2022-05-20",
            "likes": 8.0
        }
    ]
}
```

## Exemplos

### 1. Encontrar documentos com um valor específico de campo
Encontre documentos onde o campo `titulo` é "Cassandra - The Definitive Guide":

```javascript
db.collection.find({ "titulo": "Cassandra - The Definitive Guide" });
```

### 2. Encontrar documentos usando `$or`
Encontre documentos onde `likes` é maior que 50 ou o campo `by` é "Reilly Media":

```javascript
db.collection.find({
    $or: [
        { "likes": { $gt: 50 } },
        { "by": "Reilly Media" }
    ]
});
```

### 3. Encontrar documentos usando `$in`
Encontre documentos onde o campo `tags` contém "mongodb" ou "NoSQL":

```javascript
db.collection.find({
    "tags": { $in: ["mongodb", "NoSQL"] }
});
```

### 4. Encontrar documentos usando `$and`
Encontre documentos onde `likes` é maior que 50 e o campo `by` é "Reilly Media":

```javascript
db.collection.find({
    $and: [
        { "likes": { $gt: 50 } },
        { "by": "Reilly Media" }
    ]
});
```

### 5. Encontrar documentos usando `$gt` e `$lt`
Encontre documentos onde `likes` é maior que 50 e menor que 150:

```javascript
db.collection.find({
    "likes": { $gt: 50, $lt: 150 }
});
```

### 6. Encontrar documentos usando `$gte` e `$lte`
Encontre documentos onde `likes` é maior ou igual a 100 e menor ou igual a 200:

```javascript
db.collection.find({
    "likes": { $gte: 100, $lte: 200 }
});
```

### 7. Projetar campos específicos
Retorne apenas os campos `titulo` e `likes`:

```javascript
db.collection.find({}, { "titulo": 1, "likes": 1, "_id": 0 });
```

### 8. Ordenar resultados
Ordene os documentos por `likes` em ordem decrescente:

```javascript
db.collection.find().sort({ "likes": -1 });
```

### 9. Consultar campos aninhados
Encontre documentos onde o `usuario` de um comentário é "Higor":

```javascript
db.collection.find({ "comentarios.usuario": "Higor" });
```

### 10. Consultar campos aninhados com condições
Encontre documentos onde um comentário tem mais de 8 likes:

```javascript
db.collection.find({ "comentarios.likes": { $gt: 8 } });
```

### 11. Combinar filtros e projeções
Encontre documentos onde `likes` é maior que 50 e retorne apenas os campos `titulo` e `likes`:

```javascript
db.collection.find(
    { "likes": { $gt: 50 } },
    { "titulo": 1, "likes": 1, "_id": 0 }
);
```

### 12. Consultar campos de array
Encontre documentos onde o array `tags` contém "NoSQL":

```javascript
db.collection.find({ "tags": "NoSQL" });
```

### 13. Consultar campos de array com `$all`
Encontre documentos onde o array `tags` contém "mongodb" e "NoSQL":

```javascript
db.collection.find({ "tags": { $all: ["mongodb", "NoSQL"] } });
```

### 14. Consultar campos de array com `$size`
Encontre documentos onde o array `tags` tem exatamente 4 elementos:

```javascript
db.collection.find({ "tags": { $size: 4 } });
```

### 15. Consultar campos de array com `$elemMatch`
Encontre documentos onde um comentário tem mais de 8 likes e foi criado por "Higor":

```javascript
db.collection.find({
    "comentarios": {
        $elemMatch: {
            "likes": { $gt: 8 },
            "usuario": "Higor"
        }
    }
});
```

### 16. Contar documentos
Conte o número de documentos onde `likes` é maior que 50:

```javascript
db.collection.countDocuments({ "likes": { $gt: 50 } });
```

### 17. Limitar resultados
Retorne apenas os 2 primeiros documentos:

```javascript
db.collection.find().limit(2);
```

### 18. Pular resultados
Ignore os 2 primeiros documentos e retorne o restante:

```javascript
db.collection.find().skip(2);
```

### 19. Combinar ordenação, pular e limitar
Ordene os documentos por `likes` em ordem decrescente, ignore os 2 primeiros e retorne os próximos 2:

```javascript
db.collection.find().sort({ "likes": -1 }).skip(2).limit(2);
```

### 20. Exemplo de agregação
Agrupe documentos pelo campo `by` e calcule o total de `likes`:

```javascript
db.collection.aggregate([
    { $group: { _id: "$by", totalLikes: { $sum: "$likes" } } }
]);
```

### 21. Usando `$lookup` para juntar coleções
Realize um `$lookup` para juntar os documentos da coleção `livros` com a coleção `editoras`, onde o campo `editora` em `livros` referencia o campo `_id` em `editoras`:

```javascript
db.livros.aggregate([
    {
        $lookup: {
            from: "editoras",
            localField: "editora",
            foreignField: "_id",
            as: "detalhesEditora"
        }
    }
]);
```

### 22. Inserindo a editora como objeto aninhado
Insira um documento na coleção `livros` com a editora como um objeto aninhado:

```javascript
db.livros.insertOne({
    "titulo": "MongoDB - Guia Completo",
    "descricao": "Aprenda MongoDB do básico ao avançado",
    "by": "Editora do Brasil",
    "url": "https://mongodb.com/",
    "tags": ["mongodb", "database", "NoSQL"],
    "likes": 150,
    "comentarios": [],
    "editora": {
        "_id": ObjectId("68194f8ba7cc4859fd5dd82c"),
        "nome": "Editora do Brasil",
        "cidade": "João Pessoa",
        "estado": "Paraíba"
    }
});
```

### 23. Exemplo de agregação com `$match`, `$project` e `$sort`
Realize uma agregação para filtrar documentos com mais de 100 likes, projetar apenas os campos `titulo` e `likes`, e ordenar os resultados em ordem decrescente de `likes`:

```javascript
db.livros.aggregate([
    { $match: { "likes": { $gt: 100 } } },
    { $project: { "titulo": 1, "likes": 1, "_id": 0 } },
    { $sort: { "likes": -1 } }
]);
```