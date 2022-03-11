public interface IRelacionamentoChecklistService 
{
    //Responsável relacionar a resposta do checklist ao registro relacionado à tarefa
    void relacionarRespostaChecklistComRelacionamentoTarefa(List<IInstanciaRespostaDomain> listaRespostas);
}