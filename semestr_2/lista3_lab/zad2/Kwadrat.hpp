#pragma once
#include "Czworokat.hpp"

class Kwadrat : public Czworokat
{
public:
    double obliczPole() override;

    Kwadrat(double _bok1, double _bok2, double _bok3, double _bok4, double _kat) :
    Czworokat(_bok1,_bok2,_bok3,_bok4,_kat){};
};