public interface IAgendamentoTarefaService 
{
    List<AgendamentoTarefaMapper> obterAgendamentoTarefaPorPerfisCliente(List<String> listaPerfilCliente); 
    MonitoramentoTarefaViewModel obterMonitoramentoAgendamentoTarefa(String idRegistro); //Responsável por retornar os dados para monitorar os agendamentos de tarefa
}