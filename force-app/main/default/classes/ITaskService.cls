public interface ITaskService 
{
    void inserirTarefa(String assunto, String proprietario, String relativo, String tipoTarefa);
    void inserirListaTarefa(List<TaskMapper> listaTarefa);
    List<TaskMapper> obterTaskPorListaWhatId(List<String> listaRelativo);
    List<TaskMapper> obterTarefasAbertasComTipoTarefaIdRegistro(STring idRegistro, Set<String> listaIdTipoTarefa, String idUsuario); //Responsável por retornar a lista de tarefas que estão em aberto informando o registro relacionado e uma lista de tipos de tarefas.
    List<TaskMapper> obterTaskPorListaWhatIdTipoTarefa(List<String> listaRelativo, List<String> tiposTarefa);
    List<TaskMapper> obterTarefasMesComIdRelativo(String idRelativo, String idProprietario);
    void verificarSeTarefaRelacionadaEstaPreenchida(String idRelativo);
}