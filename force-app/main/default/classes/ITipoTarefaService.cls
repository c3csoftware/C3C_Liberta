public interface ITipoTarefaService 
{
    ITipoTarefaDomain obterTipoTarefasPorTipoIgualQualificacaoLead();
    ITipoTarefaDomain obterTipoTarefasPorTipoIgualQualificacaoOportunidade();
    ITipoTarefaDomain obterTipoTarefaComNome(String nomeTipoTarefa);
    List<ITipoTarefaDomain> obterTipoTarefasQueNecessitamDeMonitoramento(String perfilCliente, String idUsuario); //Responsável por retornar os tipos de tarefa que precisam ser monitorados
}