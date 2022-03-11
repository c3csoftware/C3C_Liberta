public interface ITipoTarefaSelector 
{
    SObject obterTipoTarefasPorTipoIgualQualificacaoLead();
    SObject obterTipoTarefasPorTipoIgualQualificacaoOportunidade();
    SObject buscarTipoTarefaComNome(String nomeTipoTarefa); //Responsável por buscar o tipo tarefa pelo nome
    List<SObject> buscarTiposTarefaQueNecessitamDeMonitoramento(String perfilCliente, String idUsuario); //Responsável por buscar os tipos de tarefa que participam do monitoramento
}