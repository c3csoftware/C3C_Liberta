public interface ITaskCallService 
{
    String criarAtualizarTarefaChamada(CallboxChamadaViewModel callboxChamadaInfo); //Responsável por criar/atualizar tarefas de chamadas.
    List<TarefaChamadaViewModel> obterTarefasChamadasDoUsuarioAtual(); //Responsável por retornar as tarefas do tipo "Chamada" do usuário atual
    void tranferirChamada(String idTarefaChamada, String ramalTransferencia); //Responsável transferir tarefas de chamadas.
    void criarAtualizarTarefaRedirecionamentoLigacao(String idTarefa, String assunto, String numeroDestino, Boolean redirecionamentoLigacao); //Responsável por criar tarefa de ligação redirecionando
}