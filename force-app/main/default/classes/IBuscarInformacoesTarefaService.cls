public interface IBuscarInformacoesTarefaService 
{
    ITaskDomain obterTarefaPorId(String idTarefa);
    ITaskDomain obterTarefaPorTipoDeTarefaEWhatIdComLimitacao(String relativo, String nomeTipoTarefa);
    List<ITaskDomain> obterTarefaPorListId(List<String> listaIdTarefa);
}