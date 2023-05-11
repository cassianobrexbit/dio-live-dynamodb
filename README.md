# Instalação do AWS CLI e Configuração de Usuário do CLI

Este guia explica como instalar o AWS CLI e configurar um usuário do CLI no Linux. 

## Passo 1: Instalar o AWS CLI

Para instalar o AWS CLI, siga as instruções abaixo:

1. Abra o terminal do Linux.

2. Execute o seguinte comando para atualizar os pacotes existentes no sistema:
   
   ```
   sudo apt-get update
   ```

3. Execute o seguinte comando para instalar o AWS CLI:

   ```
   sudo apt-get install awscli
   ```

4. Verifique se o AWS CLI foi instalado corretamente executando o seguinte comando:

   ```
   aws --version
   ```

   Se o AWS CLI foi instalado corretamente, você verá a versão do AWS CLI instalada no sistema.

## Passo 2: Criar um Usuário na AWS

Para criar um usuário na AWS, siga as instruções abaixo:

1. Faça login na console da AWS.

2. Navegue até a página do serviço **IAM** (Identity and Access Management).

3. Clique em **Usuários** no painel de navegação esquerdo.

4. Clique no botão **Adicionar usuário**.

5. Forneça um nome de usuário para o novo usuário e selecione **Acesso programático** como tipo de acesso.

6. Clique em **Avançar**.

7. Selecione as permissões necessárias para o novo usuário. Para permitir o acesso ao DynamoDB, selecione as permissões **AmazonDynamoDBFullAccess** ou **AmazonDynamoDBReadOnlyAccess**.

8. Clique em **Avançar**.

9. Na página de tags, adicione tags se necessário. Caso contrário, clique em **Avançar**.

10. Revise as informações do usuário e clique em **Criar usuário**.

11. Anote as chaves de acesso do usuário (Access Key ID e Secret Access Key) que serão exibidas após a criação do usuário. Essas chaves serão necessárias para configurar o AWS CLI.

## Passo 3: Configurar um usuário do CLI

Para configurar um usuário do CLI, siga as instruções abaixo:

1. Abra o terminal do Linux.

2. Execute o seguinte comando para iniciar a configuração:

   ```
   aws configure
   ```

3. Serão solicitadas as seguintes informações:

   ```
   AWS Access Key ID [None]: SEU_ACCESS_KEY_ID
   AWS Secret Access Key [None]: SUA_SECRET_ACCESS_KEY
   Default region name [None]: SUA_REGIÃO_PREFERIDA
   Default output format [None]: json
   ```

   Substitua `SEU_ACCESS_KEY_ID`, `SUA_SECRET_ACCESS_KEY` e `SUA_REGIÃO_PREFERIDA` pelas informações da sua conta AWS.

   **Observação:** As chaves de acesso são confidenciais e não devem ser compartilhadas. Certifique-se de armazená-las com segurança.

4. Após fornecer as informações, execute o seguinte comando para verificar se a configuração está correta:

   ```
   aws s3 ls
   ```

   Se a configuração estiver correta, você verá a lista de buckets do S3 na sua conta AWS.

# Download do Repositório do GitHub

Para baixar o repositório do GitHub, siga as instruções abaixo:

1. Abra o terminal do Linux.

2. Execute o seguinte comando para clonar o repositório do GitHub:

   ```
   git clone https://github.com/Boo3d/dio-live-dynamodb.git
   ```


3. Após clonar o repositório, você terá acesso ao arquivo dbConfig.sh

# Executando o Arquivo dbConfig.sh

Para executar o arquivo dbConfig.sh, siga as instruções abaixo:

1. Abra o terminal do Linux.

2. Navegue até o diretório onde o arquivo dbConfig.sh está localizado.

3. Execute o seguinte comando para tornar o arquivo dbConfig.sh executável:

   ```
   chmod +x dbConfig.sh
   ```

4. Após tornar o arquivo dbConfig.sh executável, execute o seguinte comando para executar o arquivo:

   ```
   ./dbConfig.sh
   ```

5. O arquivo dbConfig.sh começará a ser executado e criará e alimentará o banco de dados do DynamoDB.

   **Observação:** Certifique-se de que as informações de acesso à conta AWS configuradas anteriormente estão corretas para que o arquivo dbConfig.sh possa interagir com o serviço DynamoDB na sua conta AWS.

Pronto!