
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Colors }
using { /Verse.org/Assets }

material_parameter_device := class(creative_device):
    @editable
    ColoredPlane : creative_prop = creative_prop{}

    @editable
    RedButton : button_device =button_device{}

    @editable
    GreenButton : button_device =button_device{}

    @editable
    BlueButton : button_device =button_device{}

    var _PlaneMaterial : Sample01.Materials.M_Sample01_material = Sample01.Materials.M_Sample01_material{}


    OnBegin<override>()<suspends>:void=
        RedButton.InteractedWithEvent.Subscribe(OnRedButtonInteractedWith)
        GreenButton.InteractedWithEvent.Subscribe(OnGreenButtonInteractedWith)
        BlueButton.InteractedWithEvent.Subscribe(OnBlueButtonInteractedWith)
        ColoredPlane.SetMaterial(_PlaneMaterial)

        return

    OnRedButtonInteractedWith(Agent : agent) : void=
        spawn{UpdateColor(color{R:=0.02})}
        return


    OnGreenButtonInteractedWith(Agent : agent) : void=
        spawn{UpdateColor(color{G:=0.02})}
        return

    OnBlueButtonInteractedWith(Agent : agent) : void=
        spawn{UpdateColor(color{B:=0.02})}
        return

    UpdateColor(DeltaColor : color)<suspends> : void=
        var IsInc : logic = true
        loop:
            if(IsInc = true):
                set _PlaneMaterial.ParamBaseColor = _PlaneMaterial.ParamBaseColor + DeltaColor
            else:
                set _PlaneMaterial.ParamBaseColor = _PlaneMaterial.ParamBaseColor - DeltaColor
            
            CurrentColor := _PlaneMaterial.ParamBaseColor


            if:
                (DeltaColor.R > 0.0 and CurrentColor.R >= 1.0) or (DeltaColor.G > 0.0 and CurrentColor.G >= 1.0) or (DeltaColor.B > 0.0 and CurrentColor.B >= 1.0)
            then:
                set IsInc = false

            if:
                IsInc = false
                (DeltaColor.R > 0.0 and CurrentColor.R <= 0.0) or (DeltaColor.G > 0.0 and CurrentColor.G <= 0.0) or (DeltaColor.B > 0.0 and CurrentColor.B <= 0.0)
            then:
                break

            Sleep(0.0)

        return

