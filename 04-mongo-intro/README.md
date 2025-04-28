# MongoDB com Docker - Passo a Passo

## Executando o MongoDB com Docker

1. **Iniciar o container do MongoDB**  
    ```bash
    docker run --name mongodb -d -p 27017:27017 mongo
    ```

3. **Acessar o MongoDB via terminal**  
    ```bash
    docker exec -it mongodb mongosh
    ```

---

## Comandos Básicos no MongoDB

### 1. **Listar Bancos de Dados**  
    show dbs

### 2. **Criar ou Selecionar um Banco de Dados**  
    use nomeDoBanco

### 3. **Inserir um Documento em uma Coleção**  
    db.nomeDaColecao.insertOne({ chave: "valor", exemplo: 123 })

### 4. **Ler Documentos de uma Coleção**  
    db.nomeDaColecao.find()

### 5. **Atualizar um Documento**  
    db.nomeDaColecao.updateOne(
         { chave: "valor" }, 
         { $set: { chaveAtualizada: "novoValor" } }
    )

### 6. **Remover um Documento**  
    db.nomeDaColecao.deleteOne({ chave: "valor" })

---

## Parar e Remover o Container do MongoDB

1. **Parar o container**  
    docker stop mongodb

2. **Remover o container**  
    docker rm mongodb
