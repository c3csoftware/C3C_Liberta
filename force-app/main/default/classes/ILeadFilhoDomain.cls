public interface ILeadFilhoDomain 
{
    LeadFilhoMapper criarLeadFilhoComChaveLeadLista(Id idRegistro, String idListaActive, String status);
    LeadFilhoMapper criarLeadFilhoComChaveLeadLista(Id idRegistro, String idListaActive, String status, String proprietario);
    List<LeadFilhoMapper> construirListLeadFilhoMapper(List<SObject> listConta);
    leadFilhoMapper obterMapper();
    SObject obterRegistro();
}