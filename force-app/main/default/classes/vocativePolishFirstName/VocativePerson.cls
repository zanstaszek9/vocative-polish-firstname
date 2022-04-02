/**
 * VocativePolishFirstName
 *
 * Component for remake first name to Polish vocative
 *
 * @author  Mariusz Mielnik <mariusz@ecbox.pl>
 * @author  Stanislaw Zan <zanstaszek9@gmail.com>
 * @license  MIT
 *
 */

/**
* @description Structure to hold name, sex and vocative
*/
public with sharing class VocativePerson {
    public final String denominatorName;
    public String sex;
    public String vocative = '';
    private String commonConjunction = 'i';

    /**
     * @description
     * @param denominatorName name in denominator (pl. mianownik) form
     * @param sex sex indication in form of letters, 'U' for 'Unable to define', 'W' for Woman, 'M' for Man, 'G' for Group
     * @param vocative name in vocative (pl. wołacz) form
     **/
    public VocativePerson(String denominatorName, String sex, String vocative) {
        this.denominatorName = denominatorName;
        this.sex = sex;
        this.vocative = vocative;
    }

    public Boolean hasDefinedVocativeAndSex() {
        return String.isNotBlank(this.vocative) && String.isNotBlank(this.sex);
    }


    public void attachConjunction(String aString) {
        if (isConjunctionBetweenTwoNames(aString)) {
            this.sex = 'G';
        }
        this.vocative += aString;
    }

    public void attachToVocativePerson(String denominatorName, VocativePolishFirstName.VocativeRule vocativeRule) {
        this.sex = (String.isBlank(this.sex)) ? this.sex = vocativeRule.gender : this.sex;
        this.vocative += vocativeRule.getVocativeName(denominatorName);
    }

    private Boolean isConjunctionBetweenTwoNames(String aString){
        //TODO make static
        return aString == commonConjunction;
    }


}