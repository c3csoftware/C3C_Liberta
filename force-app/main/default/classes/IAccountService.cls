public interface IAccountService 
{
    void porNomeEChaveEmConta(String idDaConta, LeadMapper leadMapper);
    void atribuirUsuarioComoProprietarioESetarCodigo(String idDaConta, LeadMapper leadMapper);
}