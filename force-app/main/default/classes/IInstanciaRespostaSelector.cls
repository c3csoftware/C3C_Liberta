public interface IInstanciaRespostaSelector 
{
	List<SObject> obterInstanciaRespostaPorIdTarefa(String idTarefa);
	List<SObject> buscarInstanciaRespostasLead(Set<String> idLead);
	List<SObject> buscarInstanciaRespostasPerguntaLeadConvertido(Set<String> idLead);
}