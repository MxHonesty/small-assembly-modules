#include <stdio.h>

// Functia primeste ca parametru 3 siruri si returneaza un pointer catre
// Sirul format prin concatenarea celor 3.
char *concatenare(char *sir, char *sir2, char *sir3);


int main(){
    char sir1[10], sir2[10], sir3[10];
    printf("Introduceti 3 siruri de lungime maxim 10: ");
    scanf("%s", sir1);
    scanf("%s", sir2);
    scanf("%s", sir3);
    char *new_sir = concatenare(sir1, sir2, sir3);
    printf("Sirul concatenat este %s", new_sir);
    
    return 0;
}
