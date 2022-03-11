public interface IAgendamentoTarefaSelector 
{
    List<SObject> obterAgendamentoTarefaPorPerfisCliente(List<String> listaPerfilCliente);
    List<SObject> buscarAgendamentosTarefaPorTiposTarefa(Set<String> listaIdTipoTarefa); //Responsável por buscar os agendamentos relacionados aos tipos de tarefa
}