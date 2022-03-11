public interface IPerguntaService
{
    List<IPerguntaDomain> obterPerguntasPorTipoTarefa(String tipoTarefa);
    List<IPerguntaDomain> obterPeguntasComListaIds(Set<String> listaIdPerguntas); //Responsável por retornar as perguntas dos ids informados.
}