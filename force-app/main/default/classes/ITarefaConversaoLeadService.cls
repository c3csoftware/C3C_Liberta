public interface ITarefaConversaoLeadService 
{
    void criarTarefaConversaoLead(String idLead, String idResponsavelTarefa); //Responsável por criar a tarefa para conversão do lead
    void criarListaTarefasConversaoLead(List<Map<String, Object>> listaDadosParaCriarTarefas); //Responsável por criar a tarefa para conversão do lead
}