public with sharing class selectCtrl {
    //一个oppo用来获取输入的内容 搭配apex：input 这个组件 可以在class内跳到一个lookup选择界面
    public Opportunity oppo { get; set; }
    //soql查找并存储结果对象
    public Account standardAcct = [
        SELECT id
        FROM account
        WHERE name = '標準取引先'
    ];
    public Account customAcct = [
        SELECT id
        FROM account
        WHERE name = 'カストム取引先'
    ];

    public selectCtrl() {
        /*         Id id = ApexPages.currentPage().getParameters().get('id'); */
        //每一次创建进行一次刷新
        this.oppo = new Opportunity();
    }
    //设置结果对象的跳转
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
            //null为跳转
            return null;
        }
    }

    /*   custom_select_Vfctl.jumpPage('006/e?retURL=%2F006%2Fo');
               return('sss');
  
        }else if (selectId ==customAcct) {
              custom_select_Vfctl.jumpPage('http://www.google.com'); */
}
