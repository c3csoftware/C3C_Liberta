public interface IGroupService 
{
    GroupMapper obterGroupPorNome(String nome);
    List<GroupMapper> obterGroupPorNomes(Set<String> nomes);
    GroupMapper criarFilaComNomeEMembrosFila(String nomeFila, String configRoteamentoId, List<String> nomeObjetosSuportados, Set<String> idsMembrosFila); //Responsável por criar uma fila, adicionar objetos suportados e adicionar membros
    List<GroupMapper> obterGroupPorPapelRelacionado(Set<String> idsPapel);
    List<GroupMapper> obterGroupPorTagInicio(String tag);
}