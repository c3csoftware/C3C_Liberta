public interface IAccountDomain 
{
    void atribuirNovoIdDoRegistro();
    AccountMapper obterMapper();
    SObject obterRegistro();
    AccountMapper modificarNomeDaConta(String novoNome);
    
}