public interface IAgendamentoTarefaDomain 
{
    AgendamentoTarefaMapper construirAgendamentoTarefaMapper(SObject agendamentoTarefa);
    List<AgendamentoTarefaMapper> construirListAgendamentoTarefaMapper(List<SObject> listAgendamentoTarefa);
}