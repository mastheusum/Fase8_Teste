module RequestSpecHelper
    def json_body
        # utilizar ||= faz com que a variável não seja sobrescrita caso já 
        # exista um valor dentro dela
        @json_body ||= JSON.parse(response.body)
    end
end