# Define os cabeçalhos com o token Bearer
$headers = @{
    'Authorization' = 'Bearer 5b2a5efbc5fda2ffff948979031ac33a'
}

# Define os parâmetros
$key = 'gerente'
$constraint_type = 'equals'
$value = 'lais morais'

# Monta o JSON como string
$constraints = "[{`"key`": `"$key`", `"constraint_type`": `"$constraint_type`", `"value`": `"$value`"},{`"key`": `"Created Date`", `"constraint_type`": `"greater than`", `"value`": `"2024-09-24T00:00:00.000Z`"}]"

# Monta a URL com os parâmetros
$uri = "https://www.sistemaviverbemseguros.com/version-test/api/1.1/obj/bc_outrosDados?constraints=$([System.Web.HttpUtility]::UrlEncode($constraints))"

# Faz a requisição
$response = Invoke-WebRequest -Uri $uri -Headers $headers -Method GET

# Mostra o conteúdo da resposta
$response.Content
