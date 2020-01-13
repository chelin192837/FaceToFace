package com.macro.mall.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class FacConsultationExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public FacConsultationExample() {
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

        public Criteria andDevice_idIsNull() {
            addCriterion("device_id is null");
            return (Criteria) this;
        }

        public Criteria andDevice_idIsNotNull() {
            addCriterion("device_id is not null");
            return (Criteria) this;
        }

        public Criteria andDevice_idEqualTo(String value) {
            addCriterion("device_id =", value, "device_id");
            return (Criteria) this;
        }

        public Criteria andDevice_idNotEqualTo(String value) {
            addCriterion("device_id <>", value, "device_id");
            return (Criteria) this;
        }

        public Criteria andDevice_idGreaterThan(String value) {
            addCriterion("device_id >", value, "device_id");
            return (Criteria) this;
        }

        public Criteria andDevice_idGreaterThanOrEqualTo(String value) {
            addCriterion("device_id >=", value, "device_id");
            return (Criteria) this;
        }

        public Criteria andDevice_idLessThan(String value) {
            addCriterion("device_id <", value, "device_id");
            return (Criteria) this;
        }

        public Criteria andDevice_idLessThanOrEqualTo(String value) {
            addCriterion("device_id <=", value, "device_id");
            return (Criteria) this;
        }

        public Criteria andDevice_idLike(String value) {
            addCriterion("device_id like", value, "device_id");
            return (Criteria) this;
        }

        public Criteria andDevice_idNotLike(String value) {
            addCriterion("device_id not like", value, "device_id");
            return (Criteria) this;
        }

        public Criteria andDevice_idIn(List<String> values) {
            addCriterion("device_id in", values, "device_id");
            return (Criteria) this;
        }

        public Criteria andDevice_idNotIn(List<String> values) {
            addCriterion("device_id not in", values, "device_id");
            return (Criteria) this;
        }

        public Criteria andDevice_idBetween(String value1, String value2) {
            addCriterion("device_id between", value1, value2, "device_id");
            return (Criteria) this;
        }

        public Criteria andDevice_idNotBetween(String value1, String value2) {
            addCriterion("device_id not between", value1, value2, "device_id");
            return (Criteria) this;
        }

        public Criteria andIphoneIsNull() {
            addCriterion("iphone is null");
            return (Criteria) this;
        }

        public Criteria andIphoneIsNotNull() {
            addCriterion("iphone is not null");
            return (Criteria) this;
        }

        public Criteria andIphoneEqualTo(String value) {
            addCriterion("iphone =", value, "iphone");
            return (Criteria) this;
        }

        public Criteria andIphoneNotEqualTo(String value) {
            addCriterion("iphone <>", value, "iphone");
            return (Criteria) this;
        }

        public Criteria andIphoneGreaterThan(String value) {
            addCriterion("iphone >", value, "iphone");
            return (Criteria) this;
        }

        public Criteria andIphoneGreaterThanOrEqualTo(String value) {
            addCriterion("iphone >=", value, "iphone");
            return (Criteria) this;
        }

        public Criteria andIphoneLessThan(String value) {
            addCriterion("iphone <", value, "iphone");
            return (Criteria) this;
        }

        public Criteria andIphoneLessThanOrEqualTo(String value) {
            addCriterion("iphone <=", value, "iphone");
            return (Criteria) this;
        }

        public Criteria andIphoneLike(String value) {
            addCriterion("iphone like", value, "iphone");
            return (Criteria) this;
        }

        public Criteria andIphoneNotLike(String value) {
            addCriterion("iphone not like", value, "iphone");
            return (Criteria) this;
        }

        public Criteria andIphoneIn(List<String> values) {
            addCriterion("iphone in", values, "iphone");
            return (Criteria) this;
        }

        public Criteria andIphoneNotIn(List<String> values) {
            addCriterion("iphone not in", values, "iphone");
            return (Criteria) this;
        }

        public Criteria andIphoneBetween(String value1, String value2) {
            addCriterion("iphone between", value1, value2, "iphone");
            return (Criteria) this;
        }

        public Criteria andIphoneNotBetween(String value1, String value2) {
            addCriterion("iphone not between", value1, value2, "iphone");
            return (Criteria) this;
        }

        public Criteria andOther_oneIsNull() {
            addCriterion("other_one is null");
            return (Criteria) this;
        }

        public Criteria andOther_oneIsNotNull() {
            addCriterion("other_one is not null");
            return (Criteria) this;
        }

        public Criteria andOther_oneEqualTo(String value) {
            addCriterion("other_one =", value, "other_one");
            return (Criteria) this;
        }

        public Criteria andOther_oneNotEqualTo(String value) {
            addCriterion("other_one <>", value, "other_one");
            return (Criteria) this;
        }

        public Criteria andOther_oneGreaterThan(String value) {
            addCriterion("other_one >", value, "other_one");
            return (Criteria) this;
        }

        public Criteria andOther_oneGreaterThanOrEqualTo(String value) {
            addCriterion("other_one >=", value, "other_one");
            return (Criteria) this;
        }

        public Criteria andOther_oneLessThan(String value) {
            addCriterion("other_one <", value, "other_one");
            return (Criteria) this;
        }

        public Criteria andOther_oneLessThanOrEqualTo(String value) {
            addCriterion("other_one <=", value, "other_one");
            return (Criteria) this;
        }

        public Criteria andOther_oneLike(String value) {
            addCriterion("other_one like", value, "other_one");
            return (Criteria) this;
        }

        public Criteria andOther_oneNotLike(String value) {
            addCriterion("other_one not like", value, "other_one");
            return (Criteria) this;
        }

        public Criteria andOther_oneIn(List<String> values) {
            addCriterion("other_one in", values, "other_one");
            return (Criteria) this;
        }

        public Criteria andOther_oneNotIn(List<String> values) {
            addCriterion("other_one not in", values, "other_one");
            return (Criteria) this;
        }

        public Criteria andOther_oneBetween(String value1, String value2) {
            addCriterion("other_one between", value1, value2, "other_one");
            return (Criteria) this;
        }

        public Criteria andOther_oneNotBetween(String value1, String value2) {
            addCriterion("other_one not between", value1, value2, "other_one");
            return (Criteria) this;
        }

        public Criteria andOther_twoIsNull() {
            addCriterion("other_two is null");
            return (Criteria) this;
        }

        public Criteria andOther_twoIsNotNull() {
            addCriterion("other_two is not null");
            return (Criteria) this;
        }

        public Criteria andOther_twoEqualTo(String value) {
            addCriterion("other_two =", value, "other_two");
            return (Criteria) this;
        }

        public Criteria andOther_twoNotEqualTo(String value) {
            addCriterion("other_two <>", value, "other_two");
            return (Criteria) this;
        }

        public Criteria andOther_twoGreaterThan(String value) {
            addCriterion("other_two >", value, "other_two");
            return (Criteria) this;
        }

        public Criteria andOther_twoGreaterThanOrEqualTo(String value) {
            addCriterion("other_two >=", value, "other_two");
            return (Criteria) this;
        }

        public Criteria andOther_twoLessThan(String value) {
            addCriterion("other_two <", value, "other_two");
            return (Criteria) this;
        }

        public Criteria andOther_twoLessThanOrEqualTo(String value) {
            addCriterion("other_two <=", value, "other_two");
            return (Criteria) this;
        }

        public Criteria andOther_twoLike(String value) {
            addCriterion("other_two like", value, "other_two");
            return (Criteria) this;
        }

        public Criteria andOther_twoNotLike(String value) {
            addCriterion("other_two not like", value, "other_two");
            return (Criteria) this;
        }

        public Criteria andOther_twoIn(List<String> values) {
            addCriterion("other_two in", values, "other_two");
            return (Criteria) this;
        }

        public Criteria andOther_twoNotIn(List<String> values) {
            addCriterion("other_two not in", values, "other_two");
            return (Criteria) this;
        }

        public Criteria andOther_twoBetween(String value1, String value2) {
            addCriterion("other_two between", value1, value2, "other_two");
            return (Criteria) this;
        }

        public Criteria andOther_twoNotBetween(String value1, String value2) {
            addCriterion("other_two not between", value1, value2, "other_two");
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
