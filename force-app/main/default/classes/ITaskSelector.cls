public interface ITaskSelector 
{
    SObject obterTarefaPorId(String idTarefa);
    SObject obterTarefaPorTipoDeTarefaEWhatIdComLimitacao(String relativo, String nomeTipoTarefa);
    SObject obterTarefaPorIdComPop(String idRegistro);
    List<SObject> obterTaskPorListaWhatId(List<String> listaRelativo);
    List<SObject> obterTarefaPorListId(List<String> listaIdTarefa);
    List<SObject> buscarTarefasAbertasComTipoTarefaIdRelacionado(String idRegistro, Set<String> listaIdTipoTarefa, String idUsuario); //Responsável por buscar as tarefas em aberto de acordo o registro informado e os tipos de tarefa informados.
    List<SObject> obterTaskPorListaWhatIdTipoTarefa(List<String> listaRelativo, List<String> tiposTarefa);
    List<SObject> buscarTarefasMesComIdRelativo(String idRelativo, String idProprietario);
}