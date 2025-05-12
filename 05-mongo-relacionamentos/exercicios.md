## Questão 1

1. Exibir título, link, data das notícias e nome do produtor que estão relacionadas à série que contém como produtor Vince Gilligan
• Dicas:
– utilize $lookup para estabelecer uma ligação entre notícia e série;
– utilize $project para selecionar os dados que serão exibidos (titulo, link, data, serie);
– utilize $match para filtrar apenas as séries que possui como um dos produtores Vince
Gilligan.


```
db.noticias.aggregate([{
   $lookup: {
      from: 'series',
      localField: 'serie',
      foreignField: '_id',
      as: 'serie'
    }
   },
   {
    $addFields: {
      serie: { $arrayElemAt: ['$serie', 0] }
    } 
   },
   {
    $project: {
       titulo: 1,
       link: 1,
       data: 1,
       serie: {
          nome: 1,
          produtores: 1
       }
    }
   },
   {
     $match: {
        'serie.produtores': {
           $in: ['Vince Gilligan']
        }
     }
   }
])
```

2. Exibir nome, sinopse e rating da série de menor avaliação (rating).

```
db.series.aggregate([
  { 
    $project: {
       _id: 0,
       nome: 1,
       sinopse: 1,
       rating: 1
    }
  },
  {
    $sort: {
      rating: 1
    }
  },
  {
    $limit: 1
  }
]
)
```