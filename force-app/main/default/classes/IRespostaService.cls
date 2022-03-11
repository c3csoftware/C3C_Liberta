public interface IRespostaService
{
    List<IRespostaDomain> obterRespostasPorListaIdPergunta(Set<String> idsPergunta);
}