public interface IConverterLeadService 
{
    void pegarLeadPorId(String leadId);
    PageReference converterLead();
    String converterLeadComMerge(String idRegistro);
    void alterarProprietarioDoLeadParaAssessor(String idUsuarioAssessor, String idLead);
}