public without sharing virtual class ContaDomainFactory 
{
    /**
     * @description Método utilizado para criar um objeto conta a partir de alguns parâmetros.
     * 
     * @param nome -> Recebe uma String do nome da conta. 
     * @param idChaveExterna -> Recebe uma String de idChaveExterna para conta, que pode ser CPF ou CNPJ
     * @param email -> Recebe uma String de email para a conta.
     * @param telefone -> Recebe uma String de telefone para a conta.
     * @param estaSendoCriado -> Recebe um True ou False, se true então é criado o registro e colocado os valores dentro do SObject, caso False, os valores não serão colocados dentro do SObject, somente no objeto.
     * 
     * @return ContaMapper -> Retorna um objeto do tipo ContaMapper.
     */
    public static ContaMapper criarContaDomain(String nome, String idChaveExterna, String email, String telefone, Boolean estaSendoCriado)
    {
        ContaMapper contaMpp = (ContaMapper) C3C_DIContainer_Injector.newInstance('ContaMapper');
        
        contaMpp = verificarSeIdChaveExternaCpfOuCnpj(contaMpp, idChaveExterna);

        contaMpp = atribuirDadosParaConta(contaMpp, nome, idChaveExterna, email, telefone, estaSendoCriado);
        
        return contaMpp;
    } 

    // Métodos auxiliares
    private static ContaMapper verificarSeIdChaveExternaCpfOuCnpj(ContaMapper conta, String idChaveExterna)
    {
        if (idChaveExterna.length() == 14)
        {
            conta.cpf = idChaveExterna;
            conta.cnpj = '-';
        }
        else 
        {
            conta.cnpj = idChaveExterna;
            conta.cpf = '-';
        }

        return conta;
    }

    private static ContaMapper atribuirDadosParaConta(ContaMapper conta, String nome, String idChaveExterna, String email, String telefone, Boolean estaSendoCriado)
    {
        if (estaSendoCriado)
        {
            conta.nome = nome;
            conta.idChaveExterna = idChaveExterna;
            conta.email = email;
            conta.telefone = telefone;
            conta.codigoAssessorCrmXp = 'A0001';
            conta.tags = '-';

        } else 
        {
            conta.initBuild();

            conta.nome = nome;
            conta.idChaveExterna = idChaveExterna;
            conta.email = email;
            conta.telefone = telefone;
            conta.codigoAssessorCrmXp = 'A0001';
            conta.tags = '-';
       
            conta.finishBuild();
        }
        
        return conta;
    }
}