public with sharing class vfSearchPagectrl {
    //过去输入内容
    public Bank_Account__c bankAct { get; set; }

    //一个工具类用于设置 一个页面展示多少结果
    public ApexPages.StandardSetController ssc { get; set; }
    /* 变量 接收搜索结果后 根据ApexPages.StandardSetController的页面展示数量设置后返回结果给页面*/
    public List<Bank_Account__c> searchResults {
        get {
            if (ssc != null) {
                return ssc.getRecords();
            } else {
                return searchResults;
            }
        }
        set;
    }
    //用于判断是否存在结果 和因此决定的页面下半部分的表格是否展示
    public Boolean haveReslut { get; set; }
    //用于获取输入的搜索条件
    public String quertTerm;

    //用于接收一共有多少页结果的变量
    public Decimal NumberOfPages { get; set; }
    //当前页第一项在编号
    public Integer firstNum {
        get {
            if (this.pageNumber == 1) {
                this.firstNum = 1;
            } else {
                this.firstNum =
                    (pageNumber - 1) * Integer.valueOf(pageSize) + 1;
            }
            return this.firstNum;
        }
        set;
    }
    //没用进行使用的 当前页最后一项的编号
    public Integer secordNum {
        get {
            if (this.pageNumber == 1) {
                this.secordNum = ssc.getResultSize() <=
                    Integer.valueOf(pageSize)
                    ? ssc.getResultSize()
                    : Integer.valueOf(pageSize);
            } else {
                this.secordNum = pageNumber * Integer.valueOf(pageSize);
            }
            return this.secordNum;
        }
        set;
    }
    //
    public Integer totalNum { get; set; }
    //用于接收设置页面结果数量的输入
    public String pageSize;
    public String getPageSize() {
        return this.pageSize;
    }
    //一个用于设置展示结果数量的 方法
    public void setPageSize(String pageSize) {
        this.ssc.setPageSize(Integer.valueOf(pageSize));
        System.debug(this.ssc.getPageSize());
        this.searchResults = (List<Bank_Account__c>) this.ssc.getRecords();
        this.pageSize = pageSize;
        System.debug('ssc.getResultSize()' + ssc.getResultSize());
        System.debug(
            '(Decimal)Integer.valueOf(pageSize)' +
            (Decimal) Integer.valueOf(pageSize)
        );
        this.NumberOfPages = (ssc.getResultSize() /
            (Decimal) Integer.valueOf(pageSize))
            .round(System.RoundingMode.UP);
        System.debug(NumberOfPages);
        this.totalNum = ssc.getResultSize();
    }
    // 构造方法  创建新的属性 把
    public vfSearchPagectrl() {
        bankAct = new Bank_Account__c();
        searchResults = new List<Bank_Account__c>();
        this.haveReslut = true;
    }
    // 核心方法
    public void doSearch() {
        this.quertTerm = ' where Name LIKE \'%' + bankAct.SearchNo__c + '%\'';
        System.debug(quertTerm);

        Date startday = bankAct.StartDate__c;
        Date endday = bankAct.EndDate__c;

        String baseQueryString =
            'select id,name,RecordTypeId,Branch__c,Contact__c,Account__c,StartDate__c,starting_balance__c,EndDate__c from Bank_Account__c' +
            quertTerm;

        String whereDateString;
        if (startday != null && endday != null) {
            whereDateString = 'And StartDate__c < startday And EndDate__c > endday ';
            baseQueryString += whereDateString;
            System.debug(baseQueryString);
        } else if (startday != null && endday == null) {
            whereDateString = 'And StartDate__c < startday';
            baseQueryString += whereDateString;
            System.debug(baseQueryString);
        } else if (startday == null && endday != null) {
            whereDateString = 'And EndDate__c > endday';
            baseQueryString += whereDateString;
            System.debug(baseQueryString);
        }
        System.debug(baseQueryString);
        List<SObject> bankAcountList = Database.query(baseQueryString);
        this.searchResults = (List<Bank_Account__c>) bankAcountList;
        System.debug('searchResults:' + searchResults);

        if (this.searchResults.size() == 0) {
            this.haveReslut = false;
        } else {
            this.haveReslut = true;
        }

        this.ssc = new ApexPages.StandardSetController(searchResults);
        this.setPageSize('10');

        this.searchResults = (List<Bank_Account__c>) this.ssc.getRecords();
    }

    public void doClear() {
    }

    public void first() {
        this.ssc.first();
    }

    // returns the last page of records
    public void last() {
        this.ssc.last();
    }

    // returns the previous page of records
    public void previous() {
        this.ssc.previous();
    }

    // returns the next page of records
    public void next() {
        System.debug(1);
        System.debug(this.ssc.getPageSize());
        this.ssc.next();
    }

    public Boolean hasNext {
        get {
            if (this.ssc != null) {
                return this.ssc.getHasNext();
            } else {
                return false;
            }
        }
        set;
    }

    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            if (this.ssc != null) {
                return this.ssc.getHasPrevious();
            } else {
                return false;
            }
        }
        set;
    }

    // returns the page number of the current page set
    public Integer pageNumber {
        get {
            if (this.ssc != null) {
                return this.ssc.getPageNumber();
            } else {
                return 0;
            }
        }
        set;
    }
}
