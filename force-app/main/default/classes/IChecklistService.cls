public interface IChecklistService 
{
    List<PerguntaViewModel> obterListaPeguntaViewModel(String idTarefa);
    List<PerguntaViewModel> salvarRespostasDaTarefa(String idTarefa, List<PerguntaViewModel> listaDePerguntasDaTarefa);
}