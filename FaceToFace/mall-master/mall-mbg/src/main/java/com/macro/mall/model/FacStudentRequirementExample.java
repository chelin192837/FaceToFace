package com.macro.mall.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class FacStudentRequirementExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public FacStudentRequirementExample() {
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

        public Criteria andStudent_nameIsNull() {
            addCriterion("student_name is null");
            return (Criteria) this;
        }

        public Criteria andStudent_nameIsNotNull() {
            addCriterion("student_name is not null");
            return (Criteria) this;
        }

        public Criteria andStudent_nameEqualTo(String value) {
            addCriterion("student_name =", value, "student_name");
            return (Criteria) this;
        }

        public Criteria andStudent_nameNotEqualTo(String value) {
            addCriterion("student_name <>", value, "student_name");
            return (Criteria) this;
        }

        public Criteria andStudent_nameGreaterThan(String value) {
            addCriterion("student_name >", value, "student_name");
            return (Criteria) this;
        }

        public Criteria andStudent_nameGreaterThanOrEqualTo(String value) {
            addCriterion("student_name >=", value, "student_name");
            return (Criteria) this;
        }

        public Criteria andStudent_nameLessThan(String value) {
            addCriterion("student_name <", value, "student_name");
            return (Criteria) this;
        }

        public Criteria andStudent_nameLessThanOrEqualTo(String value) {
            addCriterion("student_name <=", value, "student_name");
            return (Criteria) this;
        }

        public Criteria andStudent_nameLike(String value) {
            addCriterion("student_name like", value, "student_name");
            return (Criteria) this;
        }

        public Criteria andStudent_nameNotLike(String value) {
            addCriterion("student_name not like", value, "student_name");
            return (Criteria) this;
        }

        public Criteria andStudent_nameIn(List<String> values) {
            addCriterion("student_name in", values, "student_name");
            return (Criteria) this;
        }

        public Criteria andStudent_nameNotIn(List<String> values) {
            addCriterion("student_name not in", values, "student_name");
            return (Criteria) this;
        }

        public Criteria andStudent_nameBetween(String value1, String value2) {
            addCriterion("student_name between", value1, value2, "student_name");
            return (Criteria) this;
        }

        public Criteria andStudent_nameNotBetween(String value1, String value2) {
            addCriterion("student_name not between", value1, value2, "student_name");
            return (Criteria) this;
        }

        public Criteria andStudent_iphoneIsNull() {
            addCriterion("student_iphone is null");
            return (Criteria) this;
        }

        public Criteria andStudent_iphoneIsNotNull() {
            addCriterion("student_iphone is not null");
            return (Criteria) this;
        }

        public Criteria andStudent_iphoneEqualTo(String value) {
            addCriterion("student_iphone =", value, "student_iphone");
            return (Criteria) this;
        }

        public Criteria andStudent_iphoneNotEqualTo(String value) {
            addCriterion("student_iphone <>", value, "student_iphone");
            return (Criteria) this;
        }

        public Criteria andStudent_iphoneGreaterThan(String value) {
            addCriterion("student_iphone >", value, "student_iphone");
            return (Criteria) this;
        }

        public Criteria andStudent_iphoneGreaterThanOrEqualTo(String value) {
            addCriterion("student_iphone >=", value, "student_iphone");
            return (Criteria) this;
        }

        public Criteria andStudent_iphoneLessThan(String value) {
            addCriterion("student_iphone <", value, "student_iphone");
            return (Criteria) this;
        }

        public Criteria andStudent_iphoneLessThanOrEqualTo(String value) {
            addCriterion("student_iphone <=", value, "student_iphone");
            return (Criteria) this;
        }

        public Criteria andStudent_iphoneLike(String value) {
            addCriterion("student_iphone like", value, "student_iphone");
            return (Criteria) this;
        }

        public Criteria andStudent_iphoneNotLike(String value) {
            addCriterion("student_iphone not like", value, "student_iphone");
            return (Criteria) this;
        }

        public Criteria andStudent_iphoneIn(List<String> values) {
            addCriterion("student_iphone in", values, "student_iphone");
            return (Criteria) this;
        }

        public Criteria andStudent_iphoneNotIn(List<String> values) {
            addCriterion("student_iphone not in", values, "student_iphone");
            return (Criteria) this;
        }

        public Criteria andStudent_iphoneBetween(String value1, String value2) {
            addCriterion("student_iphone between", value1, value2, "student_iphone");
            return (Criteria) this;
        }

        public Criteria andStudent_iphoneNotBetween(String value1, String value2) {
            addCriterion("student_iphone not between", value1, value2, "student_iphone");
            return (Criteria) this;
        }

        public Criteria andTeach_flagIsNull() {
            addCriterion("teach_flag is null");
            return (Criteria) this;
        }

        public Criteria andTeach_flagIsNotNull() {
            addCriterion("teach_flag is not null");
            return (Criteria) this;
        }

        public Criteria andTeach_flagEqualTo(String value) {
            addCriterion("teach_flag =", value, "teach_flag");
            return (Criteria) this;
        }

        public Criteria andTeach_flagNotEqualTo(String value) {
            addCriterion("teach_flag <>", value, "teach_flag");
            return (Criteria) this;
        }

        public Criteria andTeach_flagGreaterThan(String value) {
            addCriterion("teach_flag >", value, "teach_flag");
            return (Criteria) this;
        }

        public Criteria andTeach_flagGreaterThanOrEqualTo(String value) {
            addCriterion("teach_flag >=", value, "teach_flag");
            return (Criteria) this;
        }

        public Criteria andTeach_flagLessThan(String value) {
            addCriterion("teach_flag <", value, "teach_flag");
            return (Criteria) this;
        }

        public Criteria andTeach_flagLessThanOrEqualTo(String value) {
            addCriterion("teach_flag <=", value, "teach_flag");
            return (Criteria) this;
        }

        public Criteria andTeach_flagLike(String value) {
            addCriterion("teach_flag like", value, "teach_flag");
            return (Criteria) this;
        }

        public Criteria andTeach_flagNotLike(String value) {
            addCriterion("teach_flag not like", value, "teach_flag");
            return (Criteria) this;
        }

        public Criteria andTeach_flagIn(List<String> values) {
            addCriterion("teach_flag in", values, "teach_flag");
            return (Criteria) this;
        }

        public Criteria andTeach_flagNotIn(List<String> values) {
            addCriterion("teach_flag not in", values, "teach_flag");
            return (Criteria) this;
        }

        public Criteria andTeach_flagBetween(String value1, String value2) {
            addCriterion("teach_flag between", value1, value2, "teach_flag");
            return (Criteria) this;
        }

        public Criteria andTeach_flagNotBetween(String value1, String value2) {
            addCriterion("teach_flag not between", value1, value2, "teach_flag");
            return (Criteria) this;
        }

        public Criteria andTeach_sexIsNull() {
            addCriterion("teach_sex is null");
            return (Criteria) this;
        }

        public Criteria andTeach_sexIsNotNull() {
            addCriterion("teach_sex is not null");
            return (Criteria) this;
        }

        public Criteria andTeach_sexEqualTo(String value) {
            addCriterion("teach_sex =", value, "teach_sex");
            return (Criteria) this;
        }

        public Criteria andTeach_sexNotEqualTo(String value) {
            addCriterion("teach_sex <>", value, "teach_sex");
            return (Criteria) this;
        }

        public Criteria andTeach_sexGreaterThan(String value) {
            addCriterion("teach_sex >", value, "teach_sex");
            return (Criteria) this;
        }

        public Criteria andTeach_sexGreaterThanOrEqualTo(String value) {
            addCriterion("teach_sex >=", value, "teach_sex");
            return (Criteria) this;
        }

        public Criteria andTeach_sexLessThan(String value) {
            addCriterion("teach_sex <", value, "teach_sex");
            return (Criteria) this;
        }

        public Criteria andTeach_sexLessThanOrEqualTo(String value) {
            addCriterion("teach_sex <=", value, "teach_sex");
            return (Criteria) this;
        }

        public Criteria andTeach_sexLike(String value) {
            addCriterion("teach_sex like", value, "teach_sex");
            return (Criteria) this;
        }

        public Criteria andTeach_sexNotLike(String value) {
            addCriterion("teach_sex not like", value, "teach_sex");
            return (Criteria) this;
        }

        public Criteria andTeach_sexIn(List<String> values) {
            addCriterion("teach_sex in", values, "teach_sex");
            return (Criteria) this;
        }

        public Criteria andTeach_sexNotIn(List<String> values) {
            addCriterion("teach_sex not in", values, "teach_sex");
            return (Criteria) this;
        }

        public Criteria andTeach_sexBetween(String value1, String value2) {
            addCriterion("teach_sex between", value1, value2, "teach_sex");
            return (Criteria) this;
        }

        public Criteria andTeach_sexNotBetween(String value1, String value2) {
            addCriterion("teach_sex not between", value1, value2, "teach_sex");
            return (Criteria) this;
        }

        public Criteria andTeach_majorIsNull() {
            addCriterion("teach_major is null");
            return (Criteria) this;
        }

        public Criteria andTeach_majorIsNotNull() {
            addCriterion("teach_major is not null");
            return (Criteria) this;
        }

        public Criteria andTeach_majorEqualTo(String value) {
            addCriterion("teach_major =", value, "teach_major");
            return (Criteria) this;
        }

        public Criteria andTeach_majorNotEqualTo(String value) {
            addCriterion("teach_major <>", value, "teach_major");
            return (Criteria) this;
        }

        public Criteria andTeach_majorGreaterThan(String value) {
            addCriterion("teach_major >", value, "teach_major");
            return (Criteria) this;
        }

        public Criteria andTeach_majorGreaterThanOrEqualTo(String value) {
            addCriterion("teach_major >=", value, "teach_major");
            return (Criteria) this;
        }

        public Criteria andTeach_majorLessThan(String value) {
            addCriterion("teach_major <", value, "teach_major");
            return (Criteria) this;
        }

        public Criteria andTeach_majorLessThanOrEqualTo(String value) {
            addCriterion("teach_major <=", value, "teach_major");
            return (Criteria) this;
        }

        public Criteria andTeach_majorLike(String value) {
            addCriterion("teach_major like", value, "teach_major");
            return (Criteria) this;
        }

        public Criteria andTeach_majorNotLike(String value) {
            addCriterion("teach_major not like", value, "teach_major");
            return (Criteria) this;
        }

        public Criteria andTeach_majorIn(List<String> values) {
            addCriterion("teach_major in", values, "teach_major");
            return (Criteria) this;
        }

        public Criteria andTeach_majorNotIn(List<String> values) {
            addCriterion("teach_major not in", values, "teach_major");
            return (Criteria) this;
        }

        public Criteria andTeach_majorBetween(String value1, String value2) {
            addCriterion("teach_major between", value1, value2, "teach_major");
            return (Criteria) this;
        }

        public Criteria andTeach_majorNotBetween(String value1, String value2) {
            addCriterion("teach_major not between", value1, value2, "teach_major");
            return (Criteria) this;
        }

        public Criteria andTeach_subjectIsNull() {
            addCriterion("teach_subject is null");
            return (Criteria) this;
        }

        public Criteria andTeach_subjectIsNotNull() {
            addCriterion("teach_subject is not null");
            return (Criteria) this;
        }

        public Criteria andTeach_subjectEqualTo(String value) {
            addCriterion("teach_subject =", value, "teach_subject");
            return (Criteria) this;
        }

        public Criteria andTeach_subjectNotEqualTo(String value) {
            addCriterion("teach_subject <>", value, "teach_subject");
            return (Criteria) this;
        }

        public Criteria andTeach_subjectGreaterThan(String value) {
            addCriterion("teach_subject >", value, "teach_subject");
            return (Criteria) this;
        }

        public Criteria andTeach_subjectGreaterThanOrEqualTo(String value) {
            addCriterion("teach_subject >=", value, "teach_subject");
            return (Criteria) this;
        }

        public Criteria andTeach_subjectLessThan(String value) {
            addCriterion("teach_subject <", value, "teach_subject");
            return (Criteria) this;
        }

        public Criteria andTeach_subjectLessThanOrEqualTo(String value) {
            addCriterion("teach_subject <=", value, "teach_subject");
            return (Criteria) this;
        }

        public Criteria andTeach_subjectLike(String value) {
            addCriterion("teach_subject like", value, "teach_subject");
            return (Criteria) this;
        }

        public Criteria andTeach_subjectNotLike(String value) {
            addCriterion("teach_subject not like", value, "teach_subject");
            return (Criteria) this;
        }

        public Criteria andTeach_subjectIn(List<String> values) {
            addCriterion("teach_subject in", values, "teach_subject");
            return (Criteria) this;
        }

        public Criteria andTeach_subjectNotIn(List<String> values) {
            addCriterion("teach_subject not in", values, "teach_subject");
            return (Criteria) this;
        }

        public Criteria andTeach_subjectBetween(String value1, String value2) {
            addCriterion("teach_subject between", value1, value2, "teach_subject");
            return (Criteria) this;
        }

        public Criteria andTeach_subjectNotBetween(String value1, String value2) {
            addCriterion("teach_subject not between", value1, value2, "teach_subject");
            return (Criteria) this;
        }

        public Criteria andTeach_advantageIsNull() {
            addCriterion("teach_advantage is null");
            return (Criteria) this;
        }

        public Criteria andTeach_advantageIsNotNull() {
            addCriterion("teach_advantage is not null");
            return (Criteria) this;
        }

        public Criteria andTeach_advantageEqualTo(String value) {
            addCriterion("teach_advantage =", value, "teach_advantage");
            return (Criteria) this;
        }

        public Criteria andTeach_advantageNotEqualTo(String value) {
            addCriterion("teach_advantage <>", value, "teach_advantage");
            return (Criteria) this;
        }

        public Criteria andTeach_advantageGreaterThan(String value) {
            addCriterion("teach_advantage >", value, "teach_advantage");
            return (Criteria) this;
        }

        public Criteria andTeach_advantageGreaterThanOrEqualTo(String value) {
            addCriterion("teach_advantage >=", value, "teach_advantage");
            return (Criteria) this;
        }

        public Criteria andTeach_advantageLessThan(String value) {
            addCriterion("teach_advantage <", value, "teach_advantage");
            return (Criteria) this;
        }

        public Criteria andTeach_advantageLessThanOrEqualTo(String value) {
            addCriterion("teach_advantage <=", value, "teach_advantage");
            return (Criteria) this;
        }

        public Criteria andTeach_advantageLike(String value) {
            addCriterion("teach_advantage like", value, "teach_advantage");
            return (Criteria) this;
        }

        public Criteria andTeach_advantageNotLike(String value) {
            addCriterion("teach_advantage not like", value, "teach_advantage");
            return (Criteria) this;
        }

        public Criteria andTeach_advantageIn(List<String> values) {
            addCriterion("teach_advantage in", values, "teach_advantage");
            return (Criteria) this;
        }

        public Criteria andTeach_advantageNotIn(List<String> values) {
            addCriterion("teach_advantage not in", values, "teach_advantage");
            return (Criteria) this;
        }

        public Criteria andTeach_advantageBetween(String value1, String value2) {
            addCriterion("teach_advantage between", value1, value2, "teach_advantage");
            return (Criteria) this;
        }

        public Criteria andTeach_advantageNotBetween(String value1, String value2) {
            addCriterion("teach_advantage not between", value1, value2, "teach_advantage");
            return (Criteria) this;
        }

        public Criteria andProblemIsNull() {
            addCriterion("problem is null");
            return (Criteria) this;
        }

        public Criteria andProblemIsNotNull() {
            addCriterion("problem is not null");
            return (Criteria) this;
        }

        public Criteria andProblemEqualTo(String value) {
            addCriterion("problem =", value, "problem");
            return (Criteria) this;
        }

        public Criteria andProblemNotEqualTo(String value) {
            addCriterion("problem <>", value, "problem");
            return (Criteria) this;
        }

        public Criteria andProblemGreaterThan(String value) {
            addCriterion("problem >", value, "problem");
            return (Criteria) this;
        }

        public Criteria andProblemGreaterThanOrEqualTo(String value) {
            addCriterion("problem >=", value, "problem");
            return (Criteria) this;
        }

        public Criteria andProblemLessThan(String value) {
            addCriterion("problem <", value, "problem");
            return (Criteria) this;
        }

        public Criteria andProblemLessThanOrEqualTo(String value) {
            addCriterion("problem <=", value, "problem");
            return (Criteria) this;
        }

        public Criteria andProblemLike(String value) {
            addCriterion("problem like", value, "problem");
            return (Criteria) this;
        }

        public Criteria andProblemNotLike(String value) {
            addCriterion("problem not like", value, "problem");
            return (Criteria) this;
        }

        public Criteria andProblemIn(List<String> values) {
            addCriterion("problem in", values, "problem");
            return (Criteria) this;
        }

        public Criteria andProblemNotIn(List<String> values) {
            addCriterion("problem not in", values, "problem");
            return (Criteria) this;
        }

        public Criteria andProblemBetween(String value1, String value2) {
            addCriterion("problem between", value1, value2, "problem");
            return (Criteria) this;
        }

        public Criteria andProblemNotBetween(String value1, String value2) {
            addCriterion("problem not between", value1, value2, "problem");
            return (Criteria) this;
        }

        public Criteria andOtherIsNull() {
            addCriterion("other is null");
            return (Criteria) this;
        }

        public Criteria andOtherIsNotNull() {
            addCriterion("other is not null");
            return (Criteria) this;
        }

        public Criteria andOtherEqualTo(String value) {
            addCriterion("other =", value, "other");
            return (Criteria) this;
        }

        public Criteria andOtherNotEqualTo(String value) {
            addCriterion("other <>", value, "other");
            return (Criteria) this;
        }

        public Criteria andOtherGreaterThan(String value) {
            addCriterion("other >", value, "other");
            return (Criteria) this;
        }

        public Criteria andOtherGreaterThanOrEqualTo(String value) {
            addCriterion("other >=", value, "other");
            return (Criteria) this;
        }

        public Criteria andOtherLessThan(String value) {
            addCriterion("other <", value, "other");
            return (Criteria) this;
        }

        public Criteria andOtherLessThanOrEqualTo(String value) {
            addCriterion("other <=", value, "other");
            return (Criteria) this;
        }

        public Criteria andOtherLike(String value) {
            addCriterion("other like", value, "other");
            return (Criteria) this;
        }

        public Criteria andOtherNotLike(String value) {
            addCriterion("other not like", value, "other");
            return (Criteria) this;
        }

        public Criteria andOtherIn(List<String> values) {
            addCriterion("other in", values, "other");
            return (Criteria) this;
        }

        public Criteria andOtherNotIn(List<String> values) {
            addCriterion("other not in", values, "other");
            return (Criteria) this;
        }

        public Criteria andOtherBetween(String value1, String value2) {
            addCriterion("other between", value1, value2, "other");
            return (Criteria) this;
        }

        public Criteria andOtherNotBetween(String value1, String value2) {
            addCriterion("other not between", value1, value2, "other");
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
