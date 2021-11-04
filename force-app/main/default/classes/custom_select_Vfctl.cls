public with sharing class custom_select_Vfctl {
    //定义一个私有的 final sobject 来接收standardconroller 内的数据
    public Opportunity oppo { get; set; }
    //一个String name 来接收oppo 关联的acc的name

    //Apexpages.StandardController standardCtl  WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
    //上面这两个应该是针对那些已经存在数据库的内容 没有存在数据库的内容应该还是使用js

    Account standardAcct = [SELECT id FROM account WHERE name = '標準取引先'];
    Account customAcct = [SELECT id FROM account WHERE name = 'カストム取引先'];

    public custom_select_Vfctl(ApexPages.StandardController controller) {
        //给controll里的数据增加field 然后再从controller取数据过来
        controller.addFields(new List<String>{ 'custom_select__c' });
        oppo = (Opportunity) controller.getRecord();
    }
    public Pagereference doPrevious() {
        Pagereference prepage = new Pagereference('/006/o');
        return prepage;
    }
    public Pagereference doNext() {
        system.debug(this.oppo.custom_select__c);
        if (this.oppo.custom_select__c == this.standardAcct.Id) {
            Pagereference nextpage = new Pagereference(
                '/001/e?retURL=%2F001%2Fo&RecordType=0125g000001quzB&ent=Account'
            );
            return nextpage;
        } else if (this.oppo.custom_select__c == this.customAcct.Id) {
            Pagereference nextpage = new Pagereference(
                'https://www.baidu.com/'
            );
            return nextpage;
        } else {
            return null;
        }
    }
}
