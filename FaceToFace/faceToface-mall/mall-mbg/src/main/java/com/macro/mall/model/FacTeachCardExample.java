package com.macro.mall.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class FacTeachCardExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public FacTeachCardExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andIdIsNull() {
            addCriterion("id is null");
            return (Criteria) this;
        }

        public Criteria andIdIsNotNull() {
            addCriterion("id is not null");
            return (Criteria) this;
        }

        public Criteria andIdEqualTo(Long value) {
            addCriterion("id =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotEqualTo(Long value) {
            addCriterion("id <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThan(Long value) {
            addCriterion("id >", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThanOrEqualTo(Long value) {
            addCriterion("id >=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThan(Long value) {
            addCriterion("id <", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThanOrEqualTo(Long value) {
            addCriterion("id <=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<Long> values) {
            addCriterion("id in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotIn(List<Long> values) {
            addCriterion("id not in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdBetween(Long value1, Long value2) {
            addCriterion("id between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotBetween(Long value1, Long value2) {
            addCriterion("id not between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andUser_idIsNull() {
            addCriterion("user_id is null");
            return (Criteria) this;
        }

        public Criteria andUser_idIsNotNull() {
            addCriterion("user_id is not null");
            return (Criteria) this;
        }

        public Criteria andUser_idEqualTo(String value) {
            addCriterion("user_id =", value, "user_id");
            return (Criteria) this;
        }

        public Criteria andUser_idNotEqualTo(String value) {
            addCriterion("user_id <>", value, "user_id");
            return (Criteria) this;
        }

        public Criteria andUser_idGreaterThan(String value) {
            addCriterion("user_id >", value, "user_id");
            return (Criteria) this;
        }

        public Criteria andUser_idGreaterThanOrEqualTo(String value) {
            addCriterion("user_id >=", value, "user_id");
            return (Criteria) this;
        }

        public Criteria andUser_idLessThan(String value) {
            addCriterion("user_id <", value, "user_id");
            return (Criteria) this;
        }

        public Criteria andUser_idLessThanOrEqualTo(String value) {
            addCriterion("user_id <=", value, "user_id");
            return (Criteria) this;
        }

        public Criteria andUser_idLike(String value) {
            addCriterion("user_id like", value, "user_id");
            return (Criteria) this;
        }

        public Criteria andUser_idNotLike(String value) {
            addCriterion("user_id not like", value, "user_id");
            return (Criteria) this;
        }

        public Criteria andUser_idIn(List<String> values) {
            addCriterion("user_id in", values, "user_id");
            return (Criteria) this;
        }

        public Criteria andUser_idNotIn(List<String> values) {
            addCriterion("user_id not in", values, "user_id");
            return (Criteria) this;
        }

        public Criteria andUser_idBetween(String value1, String value2) {
            addCriterion("user_id between", value1, value2, "user_id");
            return (Criteria) this;
        }

        public Criteria andUser_idNotBetween(String value1, String value2) {
            addCriterion("user_id not between", value1, value2, "user_id");
            return (Criteria) this;
        }

        public Criteria andIconIsNull() {
            addCriterion("icon is null");
            return (Criteria) this;
        }

        public Criteria andIconIsNotNull() {
            addCriterion("icon is not null");
            return (Criteria) this;
        }

        public Criteria andIconEqualTo(String value) {
            addCriterion("icon =", value, "icon");
            return (Criteria) this;
        }

        public Criteria andIconNotEqualTo(String value) {
            addCriterion("icon <>", value, "icon");
            return (Criteria) this;
        }

        public Criteria andIconGreaterThan(String value) {
            addCriterion("icon >", value, "icon");
            return (Criteria) this;
        }

        public Criteria andIconGreaterThanOrEqualTo(String value) {
            addCriterion("icon >=", value, "icon");
            return (Criteria) this;
        }

        public Criteria andIconLessThan(String value) {
            addCriterion("icon <", value, "icon");
            return (Criteria) this;
        }

        public Criteria andIconLessThanOrEqualTo(String value) {
            addCriterion("icon <=", value, "icon");
            return (Criteria) this;
        }

        public Criteria andIconLike(String value) {
            addCriterion("icon like", value, "icon");
            return (Criteria) this;
        }

        public Criteria andIconNotLike(String value) {
            addCriterion("icon not like", value, "icon");
            return (Criteria) this;
        }

        public Criteria andIconIn(List<String> values) {
            addCriterion("icon in", values, "icon");
            return (Criteria) this;
        }

        public Criteria andIconNotIn(List<String> values) {
            addCriterion("icon not in", values, "icon");
            return (Criteria) this;
        }

        public Criteria andIconBetween(String value1, String value2) {
            addCriterion("icon between", value1, value2, "icon");
            return (Criteria) this;
        }

        public Criteria andIconNotBetween(String value1, String value2) {
            addCriterion("icon not between", value1, value2, "icon");
            return (Criteria) this;
        }

        public Criteria andFile_url1IsNull() {
            addCriterion("file_url1 is null");
            return (Criteria) this;
        }

        public Criteria andFile_url1IsNotNull() {
            addCriterion("file_url1 is not null");
            return (Criteria) this;
        }

        public Criteria andFile_url1EqualTo(String value) {
            addCriterion("file_url1 =", value, "file_url1");
            return (Criteria) this;
        }

        public Criteria andFile_url1NotEqualTo(String value) {
            addCriterion("file_url1 <>", value, "file_url1");
            return (Criteria) this;
        }

        public Criteria andFile_url1GreaterThan(String value) {
            addCriterion("file_url1 >", value, "file_url1");
            return (Criteria) this;
        }

        public Criteria andFile_url1GreaterThanOrEqualTo(String value) {
            addCriterion("file_url1 >=", value, "file_url1");
            return (Criteria) this;
        }

        public Criteria andFile_url1LessThan(String value) {
            addCriterion("file_url1 <", value, "file_url1");
            return (Criteria) this;
        }

        public Criteria andFile_url1LessThanOrEqualTo(String value) {
            addCriterion("file_url1 <=", value, "file_url1");
            return (Criteria) this;
        }

        public Criteria andFile_url1Like(String value) {
            addCriterion("file_url1 like", value, "file_url1");
            return (Criteria) this;
        }

        public Criteria andFile_url1NotLike(String value) {
            addCriterion("file_url1 not like", value, "file_url1");
            return (Criteria) this;
        }

        public Criteria andFile_url1In(List<String> values) {
            addCriterion("file_url1 in", values, "file_url1");
            return (Criteria) this;
        }

        public Criteria andFile_url1NotIn(List<String> values) {
            addCriterion("file_url1 not in", values, "file_url1");
            return (Criteria) this;
        }

        public Criteria andFile_url1Between(String value1, String value2) {
            addCriterion("file_url1 between", value1, value2, "file_url1");
            return (Criteria) this;
        }

        public Criteria andFile_url1NotBetween(String value1, String value2) {
            addCriterion("file_url1 not between", value1, value2, "file_url1");
            return (Criteria) this;
        }

        public Criteria andFile_url2IsNull() {
            addCriterion("file_url2 is null");
            return (Criteria) this;
        }

        public Criteria andFile_url2IsNotNull() {
            addCriterion("file_url2 is not null");
            return (Criteria) this;
        }

        public Criteria andFile_url2EqualTo(String value) {
            addCriterion("file_url2 =", value, "file_url2");
            return (Criteria) this;
        }

        public Criteria andFile_url2NotEqualTo(String value) {
            addCriterion("file_url2 <>", value, "file_url2");
            return (Criteria) this;
        }

        public Criteria andFile_url2GreaterThan(String value) {
            addCriterion("file_url2 >", value, "file_url2");
            return (Criteria) this;
        }

        public Criteria andFile_url2GreaterThanOrEqualTo(String value) {
            addCriterion("file_url2 >=", value, "file_url2");
            return (Criteria) this;
        }

        public Criteria andFile_url2LessThan(String value) {
            addCriterion("file_url2 <", value, "file_url2");
            return (Criteria) this;
        }

        public Criteria andFile_url2LessThanOrEqualTo(String value) {
            addCriterion("file_url2 <=", value, "file_url2");
            return (Criteria) this;
        }

        public Criteria andFile_url2Like(String value) {
            addCriterion("file_url2 like", value, "file_url2");
            return (Criteria) this;
        }

        public Criteria andFile_url2NotLike(String value) {
            addCriterion("file_url2 not like", value, "file_url2");
            return (Criteria) this;
        }

        public Criteria andFile_url2In(List<String> values) {
            addCriterion("file_url2 in", values, "file_url2");
            return (Criteria) this;
        }

        public Criteria andFile_url2NotIn(List<String> values) {
            addCriterion("file_url2 not in", values, "file_url2");
            return (Criteria) this;
        }

        public Criteria andFile_url2Between(String value1, String value2) {
            addCriterion("file_url2 between", value1, value2, "file_url2");
            return (Criteria) this;
        }

        public Criteria andFile_url2NotBetween(String value1, String value2) {
            addCriterion("file_url2 not between", value1, value2, "file_url2");
            return (Criteria) this;
        }

        public Criteria andFile_url3IsNull() {
            addCriterion("file_url3 is null");
            return (Criteria) this;
        }

        public Criteria andFile_url3IsNotNull() {
            addCriterion("file_url3 is not null");
            return (Criteria) this;
        }

        public Criteria andFile_url3EqualTo(String value) {
            addCriterion("file_url3 =", value, "file_url3");
            return (Criteria) this;
        }

        public Criteria andFile_url3NotEqualTo(String value) {
            addCriterion("file_url3 <>", value, "file_url3");
            return (Criteria) this;
        }

        public Criteria andFile_url3GreaterThan(String value) {
            addCriterion("file_url3 >", value, "file_url3");
            return (Criteria) this;
        }

        public Criteria andFile_url3GreaterThanOrEqualTo(String value) {
            addCriterion("file_url3 >=", value, "file_url3");
            return (Criteria) this;
        }

        public Criteria andFile_url3LessThan(String value) {
            addCriterion("file_url3 <", value, "file_url3");
            return (Criteria) this;
        }

        public Criteria andFile_url3LessThanOrEqualTo(String value) {
            addCriterion("file_url3 <=", value, "file_url3");
            return (Criteria) this;
        }

        public Criteria andFile_url3Like(String value) {
            addCriterion("file_url3 like", value, "file_url3");
            return (Criteria) this;
        }

        public Criteria andFile_url3NotLike(String value) {
            addCriterion("file_url3 not like", value, "file_url3");
            return (Criteria) this;
        }

        public Criteria andFile_url3In(List<String> values) {
            addCriterion("file_url3 in", values, "file_url3");
            return (Criteria) this;
        }

        public Criteria andFile_url3NotIn(List<String> values) {
            addCriterion("file_url3 not in", values, "file_url3");
            return (Criteria) this;
        }

        public Criteria andFile_url3Between(String value1, String value2) {
            addCriterion("file_url3 between", value1, value2, "file_url3");
            return (Criteria) this;
        }

        public Criteria andFile_url3NotBetween(String value1, String value2) {
            addCriterion("file_url3 not between", value1, value2, "file_url3");
            return (Criteria) this;
        }

        public Criteria andStatusIsNull() {
            addCriterion("status is null");
            return (Criteria) this;
        }

        public Criteria andStatusIsNotNull() {
            addCriterion("status is not null");
            return (Criteria) this;
        }

        public Criteria andStatusEqualTo(String value) {
            addCriterion("status =", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusNotEqualTo(String value) {
            addCriterion("status <>", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusGreaterThan(String value) {
            addCriterion("status >", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusGreaterThanOrEqualTo(String value) {
            addCriterion("status >=", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusLessThan(String value) {
            addCriterion("status <", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusLessThanOrEqualTo(String value) {
            addCriterion("status <=", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusLike(String value) {
            addCriterion("status like", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusNotLike(String value) {
            addCriterion("status not like", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusIn(List<String> values) {
            addCriterion("status in", values, "status");
            return (Criteria) this;
        }

        public Criteria andStatusNotIn(List<String> values) {
            addCriterion("status not in", values, "status");
            return (Criteria) this;
        }

        public Criteria andStatusBetween(String value1, String value2) {
            addCriterion("status between", value1, value2, "status");
            return (Criteria) this;
        }

        public Criteria andStatusNotBetween(String value1, String value2) {
            addCriterion("status not between", value1, value2, "status");
            return (Criteria) this;
        }

        public Criteria andRemarkIsNull() {
            addCriterion("remark is null");
            return (Criteria) this;
        }

        public Criteria andRemarkIsNotNull() {
            addCriterion("remark is not null");
            return (Criteria) this;
        }

        public Criteria andRemarkEqualTo(String value) {
            addCriterion("remark =", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkNotEqualTo(String value) {
            addCriterion("remark <>", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkGreaterThan(String value) {
            addCriterion("remark >", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkGreaterThanOrEqualTo(String value) {
            addCriterion("remark >=", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkLessThan(String value) {
            addCriterion("remark <", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkLessThanOrEqualTo(String value) {
            addCriterion("remark <=", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkLike(String value) {
            addCriterion("remark like", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkNotLike(String value) {
            addCriterion("remark not like", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkIn(List<String> values) {
            addCriterion("remark in", values, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkNotIn(List<String> values) {
            addCriterion("remark not in", values, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkBetween(String value1, String value2) {
            addCriterion("remark between", value1, value2, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkNotBetween(String value1, String value2) {
            addCriterion("remark not between", value1, value2, "remark");
            return (Criteria) this;
        }

        public Criteria andCreate_timeIsNull() {
            addCriterion("create_time is null");
            return (Criteria) this;
        }

        public Criteria andCreate_timeIsNotNull() {
            addCriterion("create_time is not null");
            return (Criteria) this;
        }

        public Criteria andCreate_timeEqualTo(Date value) {
            addCriterion("create_time =", value, "create_time");
            return (Criteria) this;
        }

        public Criteria andCreate_timeNotEqualTo(Date value) {
            addCriterion("create_time <>", value, "create_time");
            return (Criteria) this;
        }

        public Criteria andCreate_timeGreaterThan(Date value) {
            addCriterion("create_time >", value, "create_time");
            return (Criteria) this;
        }

        public Criteria andCreate_timeGreaterThanOrEqualTo(Date value) {
            addCriterion("create_time >=", value, "create_time");
            return (Criteria) this;
        }

        public Criteria andCreate_timeLessThan(Date value) {
            addCriterion("create_time <", value, "create_time");
            return (Criteria) this;
        }

        public Criteria andCreate_timeLessThanOrEqualTo(Date value) {
            addCriterion("create_time <=", value, "create_time");
            return (Criteria) this;
        }

        public Criteria andCreate_timeIn(List<Date> values) {
            addCriterion("create_time in", values, "create_time");
            return (Criteria) this;
        }

        public Criteria andCreate_timeNotIn(List<Date> values) {
            addCriterion("create_time not in", values, "create_time");
            return (Criteria) this;
        }

        public Criteria andCreate_timeBetween(Date value1, Date value2) {
            addCriterion("create_time between", value1, value2, "create_time");
            return (Criteria) this;
        }

        public Criteria andCreate_timeNotBetween(Date value1, Date value2) {
            addCriterion("create_time not between", value1, value2, "create_time");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}
