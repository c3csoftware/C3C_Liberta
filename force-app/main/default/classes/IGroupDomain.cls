public interface IGroupDomain 
{
    GroupMapper construirGroupMapper(SObject objGroup);
    List<GroupMapper> construirListGroupMapper(List<SObject> listObjGroup);
}