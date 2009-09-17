#Worker isa: Object with: 'manager'
! Worker methods !
manager: m 		
	manager := m !!  

|m|
(m := Manager new: 1)
  worker: Worker new;
  worker: Worker new.
m rand oo.
m reset.
m rand oo.
