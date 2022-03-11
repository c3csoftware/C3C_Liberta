public interface ILeadStatusDomain 
{
    void atribuirNovoIdDoRegistro();
    LeadStatusMapper obterMapper();
    SObject obterRegistro();
    String pegarMasterLabel();
    
}